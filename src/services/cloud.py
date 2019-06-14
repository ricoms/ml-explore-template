import zipfile

import boto3
from botocore.exceptions import ClientError

import constants
from services.logger import set_up_logging


logger = set_up_logging(__name__)


def download(file_path, remote_path):
    
    if file_path.exists():
        logger.info(f"Data already local at: {file_path}")
    else:
        try:
            s3 = boto3.client('s3')
            logger.info(f"Getting {file_path} from {BUCKET}/{remote_path}")
            with open(file_path, 'wb') as data:
                s3.download_fileobj(BUCKET, remote_path, data)
        except ClientError as e:
            logging.error(e)
            return False
    return True
        

def upload(file_path, remote_path):
    try:
        s3 = boto3.client('s3')
        response = s3.upload_file(
            file_path, BUCKET, remote_path)
    except ClientError as e:
        logging.error(e)
        return False
    return True
