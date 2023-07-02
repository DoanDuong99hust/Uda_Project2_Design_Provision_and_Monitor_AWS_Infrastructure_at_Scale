import datetime
def lambda_handler(event, lambda_context):
    print('Udacity Project 2: \nDesign, Provision and Monitor AWS Infrastructure at Scale')
    return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

