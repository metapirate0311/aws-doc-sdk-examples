/*
   Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
   This file is licensed under the Apache License, Version 2.0 (the "License").
   You may not use this file except in compliance with the License. A copy of
   the License is located at
    http://aws.amazon.com/apache2.0/
   This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied. See the License for the
   specific language governing permissions and limitations under the License.
*/

#include <aws/core/Aws.h>
#include <aws/sns/SNSClient.h>
#include <aws/sns/model/ListSubscriptionsRequest.h>
#include <aws/sns/model/ListSubscriptionsResult.h>
#include <iostream>

/**
 * Lists subscriptions - demonstrates how to retrieve a list of Amazon SNS subscriptions.
 */

int main(int argc, char ** argv)
{
  if (argc != 1)
  {
    std::cout << "Usage: list_subscriptions" << std::endl;
    return 1;
  }
  // snippet-start:[sns.cpp.list_subscriptions.code]
  Aws::SDKOptions options;
  Aws::InitAPI(options);
  {
    Aws::SNS::SNSClient sns;

    Aws::SNS::Model::ListSubscriptionsRequest ls_req;

    auto ls_out = sns.ListSubscriptions(ls_req);

    if (ls_out.IsSuccess())
    {
        std::cout << "Subscriptions list:" << std::endl;
        for (auto const& subscription : ls_out.GetResult().GetSubscriptions())
        {
            std::cout << "  * " << subscription.GetSubscriptionArn() << std::endl;
        }
    }
    else
    {
      std::cout << "Error listing subscriptions " << ls_out.GetError().GetMessage() <<
        std::endl;
    }
  }

  Aws::ShutdownAPI(options);
  // snippet-end:[sns.cpp.list_subscriptions.code]
  return 0;
}
