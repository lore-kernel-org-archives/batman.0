MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <200905272329.46313.lindner_marek@yahoo.de>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
	<200905272255.32032.lindner_marek@yahoo.de>
	<560c7c9a0905270805t1a35f733mc5b5b162e8eef6b2@mail.gmail.com>
	<200905272329.46313.lindner_marek@yahoo.de>
Date: Wed, 27 May 2009 17:39:37 +0200
Message-ID: <560c7c9a0905270839t768570bdo22a862ab31f8863c@mail.gmail.com>
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

On Wed, May 27, 2009 at 5:29 PM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
> On Wednesday 27 May 2009 23:05:39 Benjamin Henrion wrote:
>> > Right, that is still on open point on my ToDo. I'd like to automate th=
at
>> > if possible but did not have a good idea how to do that.
>>
>> When a packet comes from the same interface, add a cost it.
>
> Thats a bit too brief for me. Would you mind being more verbose ? =A0:-)

Let's say a packet comes from node A interface ath0 of node B, and
there is a route on node B for the packet to go to node C, route which
use the same interface ath0. In this case, you might want to add a
cost to hop over the same wireless interface.

--=20
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
