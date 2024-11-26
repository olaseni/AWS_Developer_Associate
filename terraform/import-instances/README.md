Import existing instances into the workspace
---

There are a few ways in which existing resources can be brought into the workspace so that Terraform can be used to manage them.

Some of the more common idiomatic ways are:

- The `terraform import` CLI command
- The `import` block

I'll focus on the import block.

### The Import block

`main.tf` contains a single import block that demonstrates how it's used, by importing a single, existing AWS instance
into the workspace. Import blocks have no side effects on their own when a plan is executed. 

However, they will generate an error because they often refer to resources that are outside of Terraform's management.

A minimal import block looks like this:

```terraform
# main.tf

import {
  id = resource_id
  to = aws_instance.name
}
```

Because the resource is not imported yet, executing a plan will generate errors:

`$ terraform plan`

```commandline
 Error: Configuration for import target does not exist
│ 
│   on main.tf line 5, in import:
│    5:   to = aws_instance.my_existing_instance
│ 
```

### Generating resources

We need to run an explicit command to generate configuration for resource referenced from the import block.

`$ terraform plan -generate-config-out=main-generated.tf`

if Terraform finds the AWS resources, `main-generated.tf` will be found in the current directory. 

The `import` block can be inactivated, or removed. The generated file becomes part of the workspace. You can now continue to manage the imported resource like any other Terraform resource.
