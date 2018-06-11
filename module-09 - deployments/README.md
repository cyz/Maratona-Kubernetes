# Use cases

Create a Deployment to rollout a ReplicaSet. The ReplicaSet creates Pods in the background. Check the status of the rollout to see if it succeeds or not.

Declare the new state of the Pods by updating the PodTemplateSpec of the Deployment. A new ReplicaSet is created and the Deployment manages moving the Pods from the old ReplicaSet to the new one at a controlled rate. Each new ReplicaSet updates the revision of the Deployment.

Rollback to an earlier Deployment revision if the current state of the Deployment is not stable. Each rollback updates the revision of the Deployment.

Scale up the Deployment to facilitate more load.

Pause the Deployment to apply multiple fixes to its PodTemplateSpec and then resume it to start a new rollout.

Use the status of the Deployment as an indicator that a rollout has stuck.

Clean up older ReplicaSets that you don’t need anymore.
