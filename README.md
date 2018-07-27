# puppet-deployment
Testing the use of r10k to deploy a simple web server.

### Pulling Github repo using r10k
`sudo r10k deploy --config /home/vagrant/r10k.yaml environment -pv`

### Pulling from non-production branch
`sudo $(which puppet) agent -t --environment <NAME_OF_BRANCH>`
