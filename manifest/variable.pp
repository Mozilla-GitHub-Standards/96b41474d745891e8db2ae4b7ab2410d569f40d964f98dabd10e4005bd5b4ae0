define mysql2::variable($value) {
    include mysql2::settings
    $service_name = $mysql2::settings::service_name

    exec {
        "mysql2::variable::${name}":
            command     => "mysql -e \"set global ${name} = ${value}\"",
            environment => ['HOME=/root'],
            path        => ["/bin", "/usr/bin", "/usr/local/bin"],
            unless      => "mysql -e \'show variables like \"${name}\"' | grep  ${name}.*${value} | wc -l",
            require     => [ Service[$service_name] ];
    }
}
