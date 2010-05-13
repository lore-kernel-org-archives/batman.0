Return-Path: <andrew@lunn.ch>
Date: Thu, 13 May 2010 13:45:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100513114507.GF4946@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512173830.GA27912@kroah.com>
	<201005122056.05476.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005122056.05476.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert
 multiple /proc files to use sysfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Greg KH <greg@kroah.com>, gregkh@suse.de, Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

> The rest can be in sysfs?:
>  * /sys/class/net/<iface>/batman-adv/mesh_iface
>  * /sys/class/net/<iface>/batman-adv/iface_status
>  * /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
>  * /sys/class/net/<mesh_iface>/mesh/orig_interval
>  * /sys/class/net/<mesh_iface>/mesh/vis_mode

As far as i can see, these are all single values. I would however
suggest a few changes, to make it a bit clearer what the values are
and what units are used.

* /sys/class/net/<mesh_iface>/mesh/enable_aggregated_OGMs
* /sys/class/net/<mesh_iface>/mesh/enable_vis_data
* /sys/class/net/<mesh_iface>/mesh/orig_interval_msec

"enable" suggests the control can be enabled/disabled. It gives the
user a hint to try Boolean values: 0/1, true/false, enable/disable.
Our current code accepts 0/1 and enable/disable, so the user has a
good chance of guessing correct.

enable_aggregated_OGMs is more grammatically correct. We are
aggregating multiple OGMs into one big OGM packet.

"_msec" gives the user the units to use for the orig_interval.

I would also change the values read from the files. Currently it is
not a simple value. It is a value, plus some text which batctl uses,
or hints for the user when using cat/echo. eg:

        return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1\n",
                       aggr_status == 0 ? "disabled" : "enabled");

IMHO, we should just output 0/1, true/false/ enabled/disabled. I don't
really care which, but is should be only a single word.

For me, batctl parsing the hint the kernel returns does not make much
sense. Once this kernel ABI is defined, it will never change,
ever. Since it will never change, we can hard code the hint into
batctl. That then brings the syfs files in line with the single value
requirement. 

What we loose is the hint for people using cat/echo, not batctl. How
big a problem is this? I don't think it is a big problem. When you cat
the file you see "enabled", go guessing "disabled" is not too hard. We
already return -EINVAL when in invalid value is tried and log a
message to the kernel log. It would be easy to extend this kernel log
message with: "Usage: enable | disable.
For orig_interval_msec, i would extend the kernel log message with: 
"Usage: integer between %d  and %d", (JITTER * 2)+1, 0x00ffffff.

That i think covers all the mainline configuration options. We have a
few more in trunk. I would suggest a rename to be consistent:

enable_bonding

gateway is a bigger problem. I think it needs splitting up into a
number of files, but i don't know the code well enough, and could not
quickly find a good description of the options.

	Andrew


