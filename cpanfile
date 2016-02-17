requires 'perl', '5.006';

requires 'PadWalker';

on configure => sub {
    requires 'Module::Build::Tiny', '0.034';
};

on test => sub {
    requires 'Test::More';
};

on develop => sub {
    requires 'Test::Distribution';
};
