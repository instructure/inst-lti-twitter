var app = angular.module("App", []);

moment.lang('en', {
  relativeTime : {
    future: "%s",
    past:   "%s",
    s:  "%ds",
    m:  "%dm",
    mm: "%dm",
    h:  "%dh",
    hh: "%dh",
    d:  "%dd",
    dd: "%dd",
    M:  "%dmo",
    MM: "%dmo",
    y:  "%dy",
    yy: "%dy"
  }
});

app.filter('timeAgo', function() {
  return function(text) {
    return moment(text).fromNow();
  }
});

app.controller('Twitter', ['$scope', '$http', function($scope, $http) {
  $scope.launchParams = window.LAUNCH_PARAMS;
  $scope.rootUrl = window.ROOT_URL;
  $scope.hashtag  = ($scope.launchParams['hashtag'] || '');
  $scope.username = ($scope.launchParams['username'] || '');
  $scope.max      = ($scope.launchParams['max'] ? parseInt($scope.launchParams['max']) : 10);
  $scope.embedData = {};
  $scope.tweets = [];
  $scope.currentPage = 'list';
  $scope.headerTitle = '';

  $scope.hasCriteria = function() {
    return (($scope.hashtag !== '') || ($scope.username !== ''));
  };

  $scope.reloadTweets = function() {
    if ($scope.hasCriteria()) {
      $scope.currentPage = 'list';
      $http.get($scope.rootUrl + 'api/tweets.json?hashtag=' + $scope.hashtag + '&username=' + $scope.username + '&max=' + $scope.max).success(function(data) {
        $scope.tweets = data;
      });
    } else {
      $scope.setup();
    }
  };

  $scope.updateTitle = function() {
    if ($scope.currentPage == 'setup') {
      $scope.headerTitle = 'Setup';
    } else if ($scope.currentPage == 'list') {
      if ($scope.hashtag !== '') {
        $scope.headerTitle = '#' + $scope.hashtag;
      } else {
        $scope.headerTitle = '@' + $scope.username;
      }
    } else if ($scope.currentPage == 'embed') {
      $scope.headerTitle = 'Embed Code Generated';
    } else {
      $scope.headerTitle = 'Twitter LTI';
    }
  }

  $scope.$watch('currentPage', function() {
    $scope.updateTitle();
  });

  $scope.setup = function() {
    $scope.currentPage = 'setup';
  }

  $scope.embed = function() {
    if ($scope.hasCriteria()) {

      $http.post($scope.rootUrl + 'api/embed.json', { launch_params: $scope.launchParams, hashtag: $scope.hashtag, username: $scope.username, max: $scope.max }).success(function(data) {
        if (data['redirectUrl']) {
          window.location = data['redirectUrl'];
        } else {
          $scope.embedData = data;
          $scope.currentPage = 'embed';
        }
      });
    } else {
      $scope.setup();
    }
  }

  if ($scope.hasCriteria()) {
    $scope.reloadTweets();
  } else {
    $scope.setup();
  }

}]);