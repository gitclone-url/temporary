# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Enprytna/local_manifests.git --depth 1 -b DerpFest-AOSP .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch derp_ginkgo-user
export TZ=Asia/Jakarta
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

