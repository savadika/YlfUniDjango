from rest_framework import authentication

class PreAuthenticatedAuthentication(authentication.BaseAuthentication):
    """
    DRF authentication class that relies on authentication performed by Middleware.
    If request.user is already set and authenticated, use it.
    """
    def authenticate(self, request):
        # request._request is the original WSGI request
        user = getattr(request._request, 'user', None)
        if user and user.is_authenticated:
            return (user, None)
        return None
