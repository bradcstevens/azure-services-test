#!/bin/bash
echo 'Setting environment variables for Terraform...' 

export ARM_CLIENT_ID=33bd3311-7b2e-4d56-83a4-9d7f198756c3
export ARM_CLIENT_SECRET=da1d3ebb-3975-46e5-95c7-f23d021ecaf2
export ARM_SUBSCRIPTION_ID=dd2c542a-aeaf-4cef-9ccd-e89ae5864c3f
export ARM_TENANT_ID=de9231de-45f4-4325-ae07-8ae72052517e
export ARM_OBJECT_ID=771f7ff4-cbad-4a21-a74e-87bd1d376a9c

echo 'Set ARM_CLIENT_ID to: "'$ARM_CLIENT_ID'"'
echo 'Set ARM_CLIENT_SECRET to: "'$ARM_CLIENT_SECRET'"'
echo 'Set ARM_SUBSCRIPTION_ID to: "'$ARM_SUBSCRIPTION_ID'"'
echo 'Set ARM_TENANT_ID to: "'$ARM_TENANT_ID'"'
echo 'Set ARM_OBJECT_ID to: "'$ARM_OBJECT_ID'"'

echo 'Set environment variables for Terraform!'
