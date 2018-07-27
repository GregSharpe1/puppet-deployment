# puppet-deployment
This repo holds all files that the master server will use to configure agents. The Puppetfile contains a list of all modules required, the manifests directory holds the configurations for each module, along with any further configuration manifests.

### Pulling Github repo using r10k
`sudo r10k deploy --config /home/vagrant/r10k.yaml environment -pv`

### Pulling from non-production branch
`sudo $(which puppet) agent -t --environment <NAME_OF_BRANCH>`
