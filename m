Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4FF2A070.6000601@codigosur.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<4FF1CED5.3020100@gmail.com> <20120702164258.GE2917@ritirata.org>
	<4FF2A070.6000601@codigosur.org>
Date: Tue, 3 Jul 2012 09:52:09 +0200
Message-ID: <CAKeC-QFWQaeYJGEcJZzxqb24C5jkc=wR3BNjDtjpy1JU8=Z=Xg@mail.gmail.com>
From: Wayne Abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Jul 3, 2012 at 9:34 AM, Nicol=E1s Ech=E1niz
<nicoechaniz@codigosur.org> wrote:
> On 07/02/2012 01:42 PM, Antonio Quartulli wrote:
>> On Mon, Jul 02, 2012 at 06:39:49PM +0200, Gioacchino Mazzurco wrote:
>>> That bug was happening in Pisa some times
>>> I have discussed about that antonio too
>>
>> yeah, it was pretty much the same!
>> I hope Guido can give us good results after testing the new patches :-)
>>
>> You may want to give them a try too?? :):)
>
> I just wanted to confirm that I've come across this bug quite often but
> my setup is less tidy than guido's so it's more complex to debug.
>
> I can add that quite recently we started in a nearby town a new WCN
> project and we hit this bug the same day we put the first two nodes
> online; they could bat-ping alright but no ping at all. All started
> working after a reboot of one of the nodes.
>
> Guido noted that this bug is frequently apparent when we configure a
> node in some point of the mesh (an admin's home for instance) and then
> move this node to it's final location.
> If I get the time to do so I'll try to test if this is really the case
> or just a coincidence so far.
>

Admittedly, using the older version, In my 25 node mesh, I have also
wondered why nodes seemingly disappear without trace when doing a
nmap. As L2 throughput still  works I haven't bothered to investigate.
On the upgrade note, Is there a way to upgrade to 2012 without
reflashing the node?


Wayne A
