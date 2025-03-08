from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import FarmTypeViewSet, FarmerDataViewSet, ConfigOptionViewSet, ProfileViewSet
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from .auth.views.login_view import LoginView
from .auth.views.signup_view import SignupView

router = DefaultRouter()
router.register(r'farm-types', FarmTypeViewSet)
router.register(r'farmer-data', FarmerDataViewSet)
router.register(r'config-options', ConfigOptionViewSet)
router.register(r'profiles', ProfileViewSet)

schema_view = get_schema_view(
    openapi.Info(
        title="Farm API",
        default_version='v1',
        description="API documentation for the Farm application",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="contact@farm.local"),
        license=openapi.License(name="BSD License"),
    ),
    public=True,
)

urlpatterns = [
    path('api/', include(router.urls)),
     path('api/signup/', SignupView.as_view(), name='signup'),
    path('api/login_user/', LoginView.as_view(), name='login'),
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]