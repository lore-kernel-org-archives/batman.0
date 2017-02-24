Return-Path: <derick.deleon@gmail.com>
MIME-Version: 1.0
From: Derick Roman De Leon Leal <derick.deleon@gmail.com>
Date: Fri, 24 Feb 2017 10:48:35 -0600
Message-ID: <CAM0tZWaO3F5D1KzPX85V4ydGSj_a0cXc29xhchUwTxVcnexVdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Node freezes but still alive
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

Thanks for the quick reply Linus,

No transmission on IPv4, haven't tried on IPv6 but I assume is going
to be the same. Someone suggested that I should use a bssid that
starts with 02 (eg. 02:12:34:56:78:9A). Is this a requirement for the
mesh to work?

Should I share a batman-adv log? which packet type should be more useful?

Thanks a lot!!

Kind Regards,
Derick





> ---------- Forwarded message ----------
> From: "Linus L=C3=BCssing" <linus.luessing@c0d3.blue>
> To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a=
.n@lists.open-mesh.org>
> Cc:
> Bcc:
> Date: Fri, 24 Feb 2017 09:28:11 +0100
> Subject: Re: [B.A.T.M.A.N.] Node freezes but still alive
> Hi Derick,
>
> On Thu, Feb 23, 2017 at 05:37:55PM -0600, Derick Roman De Leon Leal wrote=
:
> > I have a little setup with two nodes and one gateway, from time to
> > time one of the nodes just stops transmitting data.
>
> Very odd indeed. Can you check whether transmitting IPv4 or
> IPv6 packets on adhoc0 directly still works when this happens?
>
> Cheers, Linus
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>
