Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 12:22:54 +0200
Message-ID: <2572327.fG3ZXXKPjB@sven-edge>
In-Reply-To: <20150517111659.492f52ef@i3.local>
References: <20150516220736.2d896b4b@i3.local> <29831806.Occmqno74R@sven-edge>
 <20150517111659.492f52ef@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1888173.2bI1LqY6zS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch to add mesh_no_rebroadcast
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart1888173.2bI1LqY6zS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 17 May 2015 11:16:59 Ruben Wisniewski wrote:
> Am Sun, 17 May 2015 09:11:18 +0200
> 
> schrieb Sven Eckelmann <sven@narfation.org>:
> > > Why are you sending a patch from Linus? And this patch doesn't
> > > apply on current master or next.
> > 
> > Just to make it more clear: I think it is not a problem to pick up
> > some old patch from someone else when the original author has no
> > problem with it. But taking a patch from someone else and then
> > without any additional information claiming to be the author is a
> > rather bad move.
> 
> It is a old patch which is fixed to apply to the latest stable version.
> 
> I talk to Simon yesterday, that it would be nice if the freifunker does
> not need to ship this patch in any installation, since we start to setup
> custom repos with this patch included and so on...
> 
> Else all freifunk-firmwares include this patch, this should be stable.

Still not a reason to drop the original author information from the patch. See 
https://www.kernel.org/doc/Documentation/SubmittingPatches under "11) Sign 
your work" for information how your modifications to the original patch could 
be documented inside the Signed-off-by part without removing the original 
authorship.

See under https://www.kernel.org/doc/Documentation/SubmittingPatches "14) The 
canonical patch format" to find out how the authorship of a patch is 
"calculated" (right under the "Subject" part of this section).

> > It is even worse that the informative commit subject + message was
> > dropped. There is also no information what you've changed before your
> > signed-off-by (which is also missing).
> 
> Yes, I removed it, since the last patches I found on this mailinglist
> does not have this information-part.

Could not find a different version of this patch on this mailing list. So 
there is no reason to drop it yourself without documenting it somewhere.

And the last patches I see on the mailing list (besides the ones from you) 
are:

 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-May/013106.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-May/013108.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-May/013109.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/013068.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/013066.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/013065.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/013064.html
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/013061.html

The only patches which don't have a long description are patches to the compat 
code, trivial checkpatch changes and the copyright stuff (sry, I refuse to 
explain why the year has changed). The compat patch without description 
doesn't will not be submitted to the Linux networking subsystem maintainer. 
And since it doesn't fix anything, the text to describe the change would be 
rather uninteresting.

I think original commit message from Linus for this patch has vital 
information to understand what the new option does, why it is needed and in 
which situation it can be used/not be used.

> So I thought this is the given
> form for this mailinglist. (There is no information about that on the
> mailinglist site).

This is not about the mailing list directly. The contributing information can 
be found under:

 * https://www.open-mesh.org/projects/open-mesh/wiki/Contribute
 * https://www.kernel.org/doc/Documentation/SubmittingPatches
 * https://www.kernel.org/doc/Documentation/CodingStyle

Kind regards,
	Sven
--nextPart1888173.2bI1LqY6zS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVWGwBAAoJEF2HCgfBJntGgI4QALGWvF1b0dMvS/ZWB9T+3hZs
nogx5h9ZBW+kG4Ym6EsmUZ2P/9Z0IwGY+FOVfpyaotBm4319xW1PZ0f2bgm5MB9I
SoVqPeFUXDlGI3MtboNjO1GzOnRHjZ0K7hzEFYhxzt/fJc8sTSd3pemXNUs/8R72
QI4jZLKB8IbCyehNnPSNSI70WrlyZ7xhaztkdOaBlRpFzb17B5t1nWcqejI8bTWp
9QkJT87eP+Idmkf2iqf2QrtafwQFhcz16K+XY7TThI071g6F7y9SPIo7ipcjU5Jr
2QPV6eennaFjI1m9CKOTOdp1oejsdheTmbC6rkHqgfornLKGR5pFx380LJ8IKSQ6
bh/z7QiUblOs3EjcpaTK0oVJr+Suomgfdm0pEcjRd6IorD2SxHm6bPAScqsCl8T2
9l3Hg2bp9a9AfMriOUeHP3B9Gbz+OHRkBZ59K1GT+T3ZHK7BF/qpx0p/njDUVqgJ
87g+G5AJmjW/kETsZBDgPs5LMcPcu+tp8xNAOOihQ5P8oMvpui74MaEaqPiAOjBI
WVtT/MqXeoGjQvCpiu/ENElYR7DKg7tHlbqBEA9Hq5AN5J/B/vHoB/9AI7MlU9t8
sczXNuJrTy1/BDaIcRUaovLf8blb3LSF26vWqw48zZwN5I1+olR4rkpfkTTz4q8D
SvHnNUUFfGbdhe3znU3y
=158d
-----END PGP SIGNATURE-----

--nextPart1888173.2bI1LqY6zS--

