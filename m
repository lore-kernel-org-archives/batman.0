Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 11 Aug 2014 23:43:53 +0200
Message-ID: <8591300.0q9XWxSvcJ@prime>
In-Reply-To: <1407465989-8763-1-git-send-email-linus.luessing@web.de>
References: <1407465989-8763-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 0/3] Multicast optimizations for bridges
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

On Friday 08 August 2014 04:46:26 Linus L=C3=BCssing wrote:
> This patchset enables the usage of the batman-adv multicast optimizat=
ions
> for scenarios involving bridges on top of e.g. bat0, too.
>=20
> Along come two more patches adding according debugging facilities
> to make it possible for the user to check why the multicast
> optimizations might not work ideally to give hints about
> what they might change about their topology.
>=20
> Cheers, Linus

As discussed in private, here are some things which I've noticed during=
 my=20
tests which should get fixed:

 * With batctl mf, in the own flag section, it reports "no querier pres=
ent +"=20
when there is actually a querier present, and "no querier present -" if=
 there=20
is no querier -> reversed logic?
 * As a beautification suggestion, you could use the flag names (U/4/6)=
 instead=20
of "+" and "." instead of "-" in the batctl mf output to make the conne=
ction=20
to the reported flags more clear
 * I didn't get any log output (from batctl log) when a querier was sha=
dowed,=20
even if batctl mf was showing that correctly. All what was reported was=
=20
IGMP/MLD querier appearing or disappearing. We've discussed that this m=
ight be=20
due to some delay in the bridge code to report that ...

In general, the tests went fine, if you can resolve these quirks then w=
e can=20
add my Reviewed/Tested by, I guess. :)

Thanks!
    Simon
