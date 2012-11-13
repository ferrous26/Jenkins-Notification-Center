# Jenkins Notifications

A client for receiving Jenkins build notifications over a plain TCP socket. Notifications
are decoded and forwarded to the Notification Center.

To configure Jenkins, install the "Jenkins Notification plugin", then you can configure
a job to have "Notification Endpoints". The endpoint should be the host that is running
this client app on port 9191.

## License

The Jenkins logo used in the application is borrowed from the Jenkins project
(jenkins-ci.org) and available under the Creative Commons Attribution-ShareAlike 3.0 Unported License.

Source code is licensed under the Creative Commons Attribution 3.0 Unported License.

Details about the license available at http://creativecommons.org/licenses/by/3.0/
