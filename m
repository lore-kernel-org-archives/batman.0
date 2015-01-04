Return-Path: <antonio@meshcoding.com>
Message-ID: <54A964D7.5070107@meshcoding.com>
Date: Sun, 04 Jan 2015 17:05:43 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
 <1869722.k5Ufm3Cai9@diderot>
In-Reply-To: <1869722.k5Ufm3Cai9@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DxVhQJIvN8BQ24ghnod0kvEF1cKmScObQ"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT
 client + orig-node memory leak
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DxVhQJIvN8BQ24ghnod0kvEF1cKmScObQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 29/12/14 04:52, Marek Lindner wrote:
> On Saturday 13 December 2014 23:32:15 Linus L=FCssing wrote:
>> This patch fixes a potential memory leak which can occur once an
>> originator times out. On timeout the according global translation tabl=
e
>> entry might not get purged correctly. Furthermore, the non purged TT
>> entry will cause its orig-node to leak, too. Which additionally can le=
ad
>> to the new multicast optimization feature not kicking in because of a
>> therefore bogus counter.
>=20
> So far, I am with you ..
>=20
>=20
>> In the wild with larger mesh networks we saw this leak quite regularly=
,
>> resulting in routers to reboot or killed processes. This was because
>> of a combination of two bugs: The bug fixed by commit
>> "batman-adv: fix delayed foreign originator recognition" (8a2ad5204674=
)
>> amplified this memory leak heavily. Since that commit I'd expect
>> it to happen rarely, probably only in paused and resumed VMs and
>> devices previously in stand-by.
>=20
> This section shouldn't be part of the official commit message. It is ha=
rdly=20
> relevant to the reviewer how often a memleak occurs and whether or not =
you=20
> need a VM to trigger it. The provided commit id isn't valid in the Linu=
x tree.
>=20
>=20
>> The issue this patch fixes is caused by batadv_orig_node_free_rcu()
>> never being called because of not yet released references to the
>> orig-node. References which were supposed to be released through
>> batadv_orig_node_free_rcu()->batadv_tt_global_del_orig().
>=20
> Could you please provide addition insight as to which references are st=
ill=20
> held ? I did look around but nothing obvious jumped at me.=20
>=20
> Generally, it wouldn't be bad if the commit message went into deeper de=
tail=20
> describing the nature of the bug instead of the middle section above to=
 make=20
> it easy to understand what is being fixed.
>=20


Hi Linus and thanks for fixing this TT bug!

I agree with Marek about extending the commit message with a better
explanation of the actual bug, but at the same time I think it is good
to keep the commit message and ID of the other involved patches.

Moreover, please keep the commit ID of our batman-adv.git tree - I'll
then take care of converting them when sending the patches upstream.

Cheers,


--=20
Antonio Quartulli


--DxVhQJIvN8BQ24ghnod0kvEF1cKmScObQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUqWTmAAoJEJgn97Bh2u9eAwcP/08JZy1gGgvuKOt/jNlIvhzG
fxd78NRDG9ITM+Rmi4qPAhUdt446/ZSRmKInGnAFKJtteFDsLVpKzEXMxRbrC3MT
x/hRxEoeU+1wb66MMRotMOV4bsPrV+BPUACoCVL8kj8QfyLU+sYP3fLT8TwuVQq6
GVxDjRiycGXhUF/zSuY4ysY7D2IkwmAzuJiAO6epctstIRzSjAImcdvRCD8kOQeu
IjsThg/mFYHf++7kWdqROrKg0TJXlggPq2A64W2g0F4ypr2Z5GscuBNLpg6wc6Sk
UMX/1oJ07bPy0YNJrksaWM4Y+1pYCMbyO9h9eJgUM21oVbDyfhx5X5kr+zgcvVmq
RIalAmaGXM5v+CkWn5293fmUrYHpNqrkLz7ok2TSEaPCmLsd5RSZP60wIU03o8W2
QKH5kmxqLMldY8JObXLlL78Om/iDg7bgLcitPiYrWB+4jIgPE76l1GCjddeScbK1
tx9gUioOTIlDMEWWnvmKXGozQxKBc9tx/+eCpIlnbdchd2LzyfQvApSlhmjMJzd5
yvVJKWlLYHMZT+Jvxd99AmSE/PemfNhlDlaBkkLt2f+1bqPSY6tskzirv4f0u9PJ
lTvN6571vxkBk99DXjUd2D42CBORaJ4Q3QY7WS5KGlvPuyg8XQEVi49hXU9Yu0uB
HVFP0xc0uz57xvjgP0OE
=yRRE
-----END PGP SIGNATURE-----

--DxVhQJIvN8BQ24ghnod0kvEF1cKmScObQ--
