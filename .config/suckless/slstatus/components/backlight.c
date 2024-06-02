/* See LICENSE file for copyright and license details. */

#include <stddef.h>

#include "../util.h"

#if defined(__linux__)
	#include <limits.h>

	#define BRIGHTNESS_MAX "/sys/class/backlight/%s/max_brightness"
	#define BRIGHTNESS_CUR "/sys/class/backlight/%s/brightness"

	const char *
	backlight_perc(const char *card)
	{
		char path[PATH_MAX];
		int max, cur;

		if (esnprintf(path, sizeof (path), BRIGHTNESS_MAX, card) < 0 ||
			pscanf(path, "%d", &max) != 1) {
			return NULL;
		}

		if (esnprintf(path, sizeof (path), BRIGHTNESS_CUR, card) < 0 ||
			pscanf(path, "%d", &cur) != 1) {
			return NULL;
		}

		if (max == 0) {
			return NULL;
		}

		return bprintf("%d%%", cur * 100 / max);
	}
#elif defined(__OpenBSD__)
	#include <fcntl.h>
	#include <sys/ioctl.h>
	#include <sys/time.h>
	#include <dev/wscons/wsconsio.h>

	const char *
	backlight_perc(const char *unused)
	{
		int fd, err;
		struct wsdisplay_param wsd_param = {
			.param = WSDISPLAYIO_PARAM_BRIGHTNESS
		};

		if ((fd = open("/dev/ttyC0", O_RDONLY)) < 0) {
			warn("could not open /dev/ttyC0");
			return NULL;
		}
		if ((err = ioctl(fd, WSDISPLAYIO_GETPARAM, &wsd_param)) < 0) {
			warn("ioctl 'WSDISPLAYIO_GETPARAM' failed");
			return NULL;
		}
		return bprintf("%d", wsd_param.curval * 100 / wsd_param.max);
	}
#elif defined(__FreeBSD__)
	#include <fcntl.h>
	#include <stdio.h>
	#include <sys/ioctl.h>
	#include <sys/backlight.h>

	#define FBSD_BACKLIGHT_DEV "/dev/backlight/%s"

	const char *
	backlight_perc(const char *card)
	{
		char buf[256];
		struct backlight_props props;
		int fd;
		
		snprintf(buf, sizeof(buf), FBSD_BACKLIGHT_DEV, card);
		if ((fd = open(buf, O_RDWR)) == -1) {
			warn("could not open %s", card);
			return NULL;
		}
		if (ioctl(fd, BACKLIGHTGETSTATUS, &props) == -1){
			warn("Cannot query the backlight device");
			return NULL;
		}

		return bprintf("%d", props.brightness);
	}
#endif
