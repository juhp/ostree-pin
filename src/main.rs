fn main() {
    let sysroot = &ostree::Sysroot::new_default();
    sysroot
        .load(gio::NONE_CANCELLABLE)
        .expect("failed to load sysroot");
    let booted = sysroot.booted_deployment().expect("no booted deployment!");
    if !(booted.is_pinned()) {
        sysroot
            .deployments()
            .iter_mut()
            .filter(|d| d.is_pinned())
            .try_for_each(|pin| sysroot.deployment_set_pinned(pin, false))
            .expect("failed to unpin deployments");
        sysroot
            .deployment_set_pinned(&booted, true)
            .expect("failed to pin booted");
    }
}
