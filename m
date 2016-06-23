Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Jun 2016 11:55:56 +0200
Message-ID: <2544329.jNlMzIK2XD@bentobox>
In-Reply-To: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart29934588.NAEMYmfLYc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sailash Moirangthem <sailashm@gmail.com>

--nextPart29934588.NAEMYmfLYc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 23 June 2016 14:54:37 Sailash Moirangthem wrote:
[..]
> I am trying to set-up mesh network using tplink WR1043ND routers and
> raspberry pi B+ integrated with ra2800usb (wi pi). The tplink routers
> are working as expected. Howoever, the raspberry pi is not working.

Sounds more like an OpenWrt/LEDE question. But I think the persons which
created the OpenWrt/LEDE scripts for batman-adv are subscribed to this
list.

> The configuration file for the Pi board is as follows:
> 
[...]
>  config interface 'mesh'
> option ifname 'adhoc0'
> option mtu '1528'
>  option proto 'batadv'
>  option mesh 'bat0'
[...]

Why are you adding the interface in /etc/config/wireless and not as
described in the quick start guide [1] to /etc/config/wireless? I would
suggest to try to use the /etc/config/wireless because these are
"dynamically" created interfaces and (not tested) should work better with
netifd.

Is it working when you do `batctl if add adhoc0`? Is something shown
in dmesg related to an error while adding the interface?

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config

--nextPart29934588.NAEMYmfLYc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXa7IsAAoJEF2HCgfBJntGsqsQANHaszTPN4YJf8QcVHSBLs5t
P/YaoaB2pL/WLz78xQUt2Oov3ubbvTfp3lB/3u6jftcXqVZoGUtVT3la902l/0eX
mYUZi7pRBQ+gqlWzp9xQdp9CHTM3IrjpFU/w9naYdEWd9pDUmH2NYvGRnwbNQuyp
7e9HnebrYWLTGc1R94PpQZOsrVZIMHtq2Y1fAHU62LduXdyN8xeV9R3atIYzSGFZ
eMuS8K11Cw74V4NYT905JrF5i+EVZyDbrSJpijKOpPf0+rYYxUoINpOBpQY5YUH7
2VGepij22/407X55hD1keWO2jSlNPVEQ/EKdG1s7BNZRXBxWdHFtRAQKcnrwJVqQ
m9W8ins5tv2oQwqnp0YtvrHQSnCIUzuanonFUqcPzPoqJZb/nkXcdEASHzx/ezvD
XMt4GJaI99y989G5CtcXfpF2Wbn2m7EQHdkbrLH8wZNQQtV9TwtC88S8jmjedXxP
fJcoqeMJlMyHJrxdK2B1ryq/GrneZQUJvlctM1bEYjrKPCmGU94RDCjtjZ5rY3qX
LcOkTQNtm4QF0+eTPwTzMdO+jc+evejBzU2rXW2J3FTCykRDkbpu/HPHhLhQvJN5
+Bawdf2GrzjMk2rvj/tEiyuVl+bRj4nFBcvwISHfK6wD+83nC9ShV0tVoDNguGBy
YHhDRTd/MzUEdjwV9LDX
=HQTr
-----END PGP SIGNATURE-----

--nextPart29934588.NAEMYmfLYc--

