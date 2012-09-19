Description
===========

Installs and gets gitosis up and running ready to serve git repos.
Works way better than the shell script that was converted into a chef
cookbook.

I have not included the FreeBSD and Ubuntu support in the cookbook
currently as more wrangling is needed there.

Requirements
============

 * Chef.
 * A SSH Public/Private keypair

Attributes
==========

 * gitosis.authorized_key - SSH RSA Public Key for user who will be
   a gitosis admin

Note: change the comment to an email address if you are using email
addresses for user identifiers or use the local part.  Keys are stored
under the gitosis-admin repo keydir as username.pub for username
or username@example.com.pub for username@example.com

Example JSON:

    {
      "gitosis": {
        "authorized_key": "ssh-rsa AAAAB..... username"
      }
    }

Usage
=====

