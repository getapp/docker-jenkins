import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def password = System.getenv("JENKINS_PASSWORD")
def user = System.getenv("JENKINS_USER")
hudsonRealm.createAccount(user, password)
instance.setSecurityRealm(hudsonRealm)
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, user)
instance.setAuthorizationStrategy(strategy)
instance.save()
