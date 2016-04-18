Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Apr 2016 13:10:23 +0200
Message-ID: <2503914.aZJTHeCJKl@bentobox>
In-Reply-To: <2005230.N8INYQKvQl@sven-edge>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <20160319084934.GD9971@prodigo.lan> <2005230.N8INYQKvQl@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1773122.arRKHFQuxU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1773122.arRKHFQuxU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 19 March 2016 10:19:39 Sven Eckelmann wrote:
> > > > > What about the "socket" file?
[...]
> How can this be implemented 100% in userspace? Lets ignore the 
> reply/forwarding part for a second and just concentrate on the initiator of 
> the ping/traceroute. It can use AF_PACKET in userspace to send batadv packets 
> directly on the hardif. But here comes the first problem... which is the 
> correct hardif? There can be multiple and the userspace does not really know 
> which one is the one the kernel would use at a particular time. So you have to 
> implement the same algorithms in userspace the emulate the kernel part (or you 
> may do something completely different). And still then you would have problems 
> when the kernel is tweaked and the userspace didn't receive this tweak.
> 
> Maybe it is necessary to ask the kernel before sending the ping by asking him 
> "hey, what interface would use use right now and what other parameters are now 
> required". Similar to what "ip route get 8.8.8.8" would do.
> 
> Or am I just overcomplicated things now?

It can also be postponed to later. No need to have this in netns from the
start.

But RTM_GETROUTE-like NLM_F_REQUEST requests sound feasible for a userspace
based ICMP-like request initiation. But most likely with generic messages
instead of structs.

Kind regards,
	Sven
--nextPart1773122.arRKHFQuxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFMCfAAoJEF2HCgfBJntGnrQQALetgivRNy8eMcBkivEjciXT
VDJL2dqmQMONHwGgXymVmCRvAp3gKmdYDP6QVHnWl0G4J54xICYH7ehIOZoELrFn
b/0Ccse2IqdFE9+RP+oPWpElkp3Uhe3uDDNmL8voxib/QU8HydpKUOn5o2S+HQDl
i/MNGMfj5tL2Fz3NiUQGsJKQIAERKxXN91tPgAwIBqEAD0AKWDcCCPwOd1TlERa3
V8BkfTdvIYoSiTOhWKxtxiErF4dwmnshTmfyAIdyzA5F/F3RFdD93N33XF0xiM3u
PSlFa71/8KfOxoo+Ycf8rdAeqXLneak10LV+ZAC9yP68FqeYNTAXg3ne7IRnjqlq
cMw2QxgbzVTnGLdwGycoaSgHuOMfjzVvEetiB73+hVsaneKI1grpzmtjraTekvWD
LeW8zKvs+9OqxCXXt3N5K+8RFhQaIZitcGy+GmH8EAw3R9yL+znh3Cl5VXaXHFZS
21xNYmoGnBwchzZNweOFKTbutcbrn5zflDaDsY7tEKhKptSSOqrliD+jdjmutpHz
ujBKTHD79XQPCWAgT/ZDIu9/yj0XoqRMqDNt9/9OXug5qHcG80F3prX5QpFWgdGr
KA1j+T3ZkLQ/EwxQ7ItikS9gQlfWti+1sE/Cl/r+0pBcpZpiVnzZxj7LaTe9dVRL
j9ph6eV4Lplt5N+UZKkQ
=s41q
-----END PGP SIGNATURE-----

--nextPart1773122.arRKHFQuxU--

