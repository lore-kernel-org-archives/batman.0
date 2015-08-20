Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 20 Aug 2015 13:09:51 +0200
Message-ID: <1648393.lLZC1ylQqN@prime>
In-Reply-To: <1439915717.1370.9.camel@nord-west.org>
References: <1439848023.1458.15.camel@nord-west.org>
 <20150818080855.GD19496@medion.lan> <1439915717.1370.9.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1702799.14LSlckWmC";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Kernel crashes when using more than one
	interface in bat0
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


--nextPart1702799.14LSlckWmC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Bjoern,

thanks a lot for reporting this issue - it looks like there are some problems 
in the cleanup of OGMs when fragmentation is used.

For now, I've created a ticket here:

https://www.open-mesh.org/issues/223

Thanks,
    Simon

On Tuesday 18 August 2015 18:35:17 Bjoern Franke wrote:
> Am Dienstag, den 18.08.2015, 10:08 +0200 schrieb Bastian Bittorf:
> > * Bjoern Franke <bjo@nord-west.org> [18.08.2015 09:47]:
> > > Unfornately we have no logs now, because after the crashes no ssh
> > > -access to the servers are possible.
> > 
> > try to set
> > 
> > /sbin/sysctl -w kernel.panic_on_oops=1
> > /sbin/sysctl -w kernel.panic=10
> > /sbin/sysctl -w vm.panic_on_oom=2
> > 
> > if the devices crashed (and reboots now) you have
> > the crash in the file:
> > 
> > /sys/kernel/debug/crashlog
> 
> Thanks for the hint, it did not work on the debian machines, but I got
> the systems running with crashkernel enabled. Now we got the first
> crash:
> https://p.rrbone.net/paste/nnNHrIJI#oHfBMOs2
> 
> Regards
> Bjoern

--nextPart1702799.14LSlckWmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXVtYMACgkQrzg/fFk7axbdVACgnF4YW9mMZtkBYWLzGAhaFxtS
5QoAoNPR2soj7wiyiEzp3bHH0muk45W0
=OGu9
-----END PGP SIGNATURE-----

--nextPart1702799.14LSlckWmC--

