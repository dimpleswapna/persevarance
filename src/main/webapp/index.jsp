trigger:
- main
stages:
- stage: BuildandPublishArtifact
  jobs:
  - job: Build
    pool:
      name: default
    steps:
    - task: Maven@3
      inputs:
        mavenPomFile: 'pom.xml'
        goals: 'package'
    - task: CopyFiles@2
      inputs:
        SourceFolder: '$(Build.SourcesDirectory)/target/'
        Contents: 'perseverance.war'
        TargetFolder: '$(Build.ArtifactStagingDirectory)/'


    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: '$(Build.ArtifactStagingDirectory)'
        ArtifactName: 'drop'
        publishLocation: 'Container'
