use ostree::Sysroot;

fn main() {
    let sysroot = Sysroot::new_default();
    sysroot
        .load(gio::Cancellable::NONE)
        .expect("failed to load sysroot");
    let booted = sysroot.booted_deployment().expect("no booted deployment!");
    if !(booted.is_pinned()) {
        sysroot
            .deployments()
            .iter()
            .filter(|d| d.is_pinned())
            .try_for_each(|pin| sysroot.deployment_set_pinned(pin, false))
            .expect("failed to unpin deployment");
        sysroot
            .deployment_set_pinned(&booted, true)
            .expect("failed to pin booted");
    }
}
