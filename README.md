# Deploy Docus

Web interface to easily deploy your application
[![Travis](https://secure.travis-ci.org/evome/deploy_docus.png)](http://travis-ci.org/evome/deploy_docus)

## Installation

Deploy Docus is only a library.
It'll require you to generate an application and deploy it in the environment of your choice.

    gem install deploy_docus
    ddocus new my_deployment_app

This will create the folder my_deployment_app with the required files.

You then need to create a new SSH key.
This key will be used to get access to your GIT repository and your deployment server.

    ssh-keygen -t rsa -C "you@example.com" -f keys/my_application_rsa

Note : the key **must** end with \_rsa.

Now, open the file `config.yml` in your generated application.
It contains all your application's informations to make the deployments.

Add your deployment information for `my_application`. For example :

    my_application:
      repository: git@github.com:my_organization/my_repository.git
      token: qhbnlkmnmh8096785nknmgiuh789BKMKGPIHMLNMÇ0HIONBON
      deploy_task:
        production: cap production deploy

And you're done ! Deploy your application somewhere (like on heroku).
And you can easily test your deployments with CURL :

    curl -X POST http://your-deploy-docus-application/my_application/production

The first parameter in the URI is the application's name.
The second one is the environment (as defined in your config.yml file).

## Contributing

We're open to any contribution. It has to be tested properly though.

* [Fork](http://help.github.com/forking/) the project
* Do your changes and commit them to your repository
* Test your changes. We won't accept any untested contributions (except if they're not testable).
* Create an [issue](https://github.com/evome/deploy_docus/issues) with a link to your commits.

## Maintainers

* Evome ([evome.fr](http://evome.fr))
* Damien MATHIEU ([github/dmathieu](http://github.com/dmathieu), [dmathieu.com](http://dmathieu.com))
* Franck VERROT ([github.com/cesario](http://github.com/cesario),[verrot.fr](http://verrot.fr/))

## License
MIT License. Copyright 2011 Evome. http://evome.fr
