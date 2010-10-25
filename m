Return-Path: <xiaoxianghua@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1288044374-11771-1-git-send-email-linus.luessing@web.de>
References: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
	<1288044374-11771-1-git-send-email-linus.luessing@web.de>
Date: Mon, 25 Oct 2010 17:16:50 -0500
Message-ID: <AANLkTim55WkJkmC8u-BidPaVH1J=hEJs2v09d-NUH4KH@mail.gmail.com>
From: Xianghua Xiao <xiaoxianghua@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv multi-hop route
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, linus.luessing@web.de

On Mon, Oct 25, 2010 at 5:06 PM, Linus L=C3=BCssing <linus.luessing@web.de>=
 wrote:
> Hi xianghua,
>
> for such test cases basically this patch had once been made to force batm=
an-adv
> onto certain routes but needed to be removed again as the way ebtables is
> used here is not standard-conforming. However, this shouldn't bother you =
:).
>
> You can then just use ebtables to prohibit certain routes:
>> ebtables -I INPUT -s MAC -j DROP or
>> ebtables -I INPUT -p 0x4305 -j DROP
>> (and the same for -I OUTPUT)
>
> Antonio had been doing tests with this ebtables patch, too (see this
> mailing list's archive from about the 10 May 2010).
>
> This is a revert of the revert of commit 660d20261343e0b2ff57e51e50d7eb0e=
557d5e5b.
> and applies on top of the current git master branch. If you need it for a=
ny
> other version of batman-adv, try 'git revert 660d20261343e0b2ff57e51e50d7=
eb0e557d5e5b'
> and if that doesn't work, just bug me again :).
>
> Cheers, Linus
>

Thanks!
Will give it a try.
Xianghua
