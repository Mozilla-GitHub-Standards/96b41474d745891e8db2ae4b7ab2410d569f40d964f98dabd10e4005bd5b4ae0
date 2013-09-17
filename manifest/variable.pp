define mysql::variable($value) {
    include mysql::settings
    $service_name = $mysql::settings::service_name

    exec {
        "mysql::variable::${name}":
            command     => "mysql -e \"set global ${name} = ${value}\"",
            environment => ['HOME=/root'],
            path        => ["/bin", "/usr/bin", "/usr/local/bin"],
            unless      => "mysql -e \'show variables like \"${name}\"' | grep  ${name}.*${value} | wc -l",
            require     => [ Service[$service_name] ];
    }
}
