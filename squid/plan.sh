pkg_name=squid
pkg_origin=atalanta
pkg_version="3.5.27"
pkg_maintainer="Stephen Nelson-Smith <stephen@atalanta-systems.com>"
pkg_license=("Apache-2.0")
pkg_source="http://www.squid-cache.org/Versions/v3/3.5/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="5ddb4367f2dc635921f9ca7a59d8b87edb0412fa203d1543393ac3c7f9fef0ec"
pkg_deps=(core/glibc core/perl core/gcc-libs)
pkg_build_deps=(core/make core/gcc core/pkg-config)
pkg_bin_dirs=(sbin bin)
pkg_svc_run="squid -N -f $pkg_svc_config_path/squid.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
pkg_svc_user="root"
pkg_svc_group="hab"
pkg_description="Squid is a caching proxy for the Web supporting HTTP, HTTPS, FTP, and more."
pkg_upstream_url="http://www.squid-cache.org/"

do_build() {
    ./configure \
        --prefix="$pkg_prefix" \
        --with-default-user="$pkg_svc_group" \
        --with-logdir="$pkg_svc_var_path/logs" \
        --with-pidfile="$pkg_svc_var_path/run/squid.pid" \
        --with-swapdir="$pkg_svc_var_path/cache" \
        --disable-native-arch \
        --disable-strict-error-checking
    make
}
