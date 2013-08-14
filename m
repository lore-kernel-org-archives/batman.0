Return-Path: <feanpg@gmail.com>
Message-ID: <520B5678.4090200@gmail.com>
Date: Wed, 14 Aug 2013 12:05:44 +0200
From: Fernando Pizarro <feanpg@gmail.com>
MIME-Version: 1.0
References: <52020C25.9080705@gmail.com> <20130807160945.GN2943@ritirata.org>
 <52027EBD.70007@gmail.com> <201308080123.50676.lindner_marek@yahoo.de>
In-Reply-To: <201308080123.50676.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] DAT issue
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

El 07/08/13 19:23, Marek Lindner escribi=F3:
> Fernando,
>
> On Thursday, August 08, 2013 01:07:09 Fernando Pizarro wrote:
>> 2) I thougt having nodes without IP and just forwarding traffic to the
>> main GW (the firewall) through batman-adv, not natting every client
>> traffic with the node IP. In that way, roaming is working very good. The
>> problem are stablished sessions, these sessions are lost jumping from a
>> node to any other. I think this problem is nearly related to the empty
>> DAT table, and empty DAT table problem is nearly related too the nodes
>> has no IP assigned. However, I'm not sure about this..
> the DAT table has nothing to do with roaming or sessions. It merely is an=
 IP
> address cache to speed up ARP lookups. Even without DAT everything should
> work. I recommend to read our DAT user guide:
> http://www.open-mesh.org/projects/batman-adv/wiki/DistributedArpTable
>
> If disabling DAT would break something we certainly would not make it an
> option to invite everybody to shoot themselves in the foot.  ;-)
>
> Therefore, I have to agree with Antonio that your problem is likely to be
> found somewhere else. First, you should define which established sessions
> break. The ones going into the internet or the ones you have locally.
> Depending on the answer we can dig deeper.
>
> Generally it is a good idea to simplfy the setup until a point where
> everything works. Then you can move forward and make things more complica=
ted.
> For the time being I'd recommend to vastly simplify your bridge & vlan se=
tup
> by bridging your AP interface with bat0 only (no vlans, no radius tags, no
> brvlanN interface) to see if your roaming works.
>
> Cheers,
> Marek
>
Hi all, thanks for your answers.

I have tested my setup in lab and I think that roaming works even if the=20
DAT table is empty, local and external established connections seems to=20
don't have problems.

Thanks for your help.
Fernando
