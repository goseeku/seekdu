(function() {
	function AuthCtrl($scope, $state, Auth) {
		
		this.login = function() {
			Auth.login($scope.user).then(function() {
				$state.go('dash');
			});
		};

		this.logout = Auth.logout;

		this.register = function() {
			Auth.register($scope.user).then(function() {
				$state.go('dash');
			});
		};

		this.pwReset = function(creds) {
			Auth.sendResetPasswordInstructions(creds).then(function() {
				$state.go('login');
			})
		};
	}

	angular
		.module('seekdu')
		.controller('AuthCtrl', ['$scope', '$state', 'Auth', AuthCtrl]);
})();