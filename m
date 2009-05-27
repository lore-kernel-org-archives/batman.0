MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24D@MBX21.stu.nus.edu.sg>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
	<278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24D@MBX21.stu.nus.edu.sg>
Date: Wed, 27 May 2009 14:09:15 +0200
Message-ID: <560c7c9a0905270509tecf2f1dr20d651918580ce9d@mail.gmail.com>
From: Benjamin Henrion <bh@udev.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] MultiRadio Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wed, May 27, 2009 at 1:52 PM, Kartik Muralidharan
<kartik_m@nus.edu.sg> wrote:
> @Marek
>
> =D8=A0=A0=A0=A0=A0=A0 what do you mean ? You want to know where in the co=
de batman handles
> multiple radio interfaces ?
>
> Yes. I have just started going through the code so wondering how multiple
> interfaces are handled.
>
> @Benjamin
>
>>At the Wireless Battle Mesh of Paris, the author of Babel wrote a
>
>>quick patch to add some cost to hop over the same wifi interface.
>>Here is a summary:
>>http://hackerspace.be/wbm2009#toc9
>
> We are trying to service the internet access through a regular
> infrastructure mode via an access point connected to the wired interface =
on
> the node. Apart from that each node has 2 wireless interfaces that can be
> used to reduce intra hop interference. So wanted to know if BATMAN can ta=
ke
> advantage of two radio on each node to improve throughput.

I tried Batman at the WBM to see if it was finding the fastest route
in terms of bandwidth, and it was not doing it. So Batman will
continue to hop on the same channel, even if another route is faster
in terms of bandwidth.

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
