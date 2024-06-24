# e_commerce

A new Flutter project.

## Flavor

- Firebase 프로젝트 분리
  - android > app > src
    - dev
    - prod
  - ios > Runner > config
    - dev
    - prod

`flutterfire configure -o lib/firebase_options_dev.dart -a com.example.e_commerce.dev -i com.example.eCommerce.dev`
로 생성한 firebase config file들을 각각 dev와 prod 경로로 이동시킨다.
주의할점은 실행전 파일을 옮기지 않으면 덮어씌워진다.
