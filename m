Return-Path: <mvanderkolff@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTikPFR+A5uGZfxB350yD4h0VXuueE+y1g2CcNxS7@mail.gmail.com>
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
	<201011292258.05388.lindner_marek@yahoo.de>
	<AANLkTikPFR+A5uGZfxB350yD4h0VXuueE+y1g2CcNxS7@mail.gmail.com>
Date: Tue, 30 Nov 2010 17:36:47 +1100
Message-ID: <AANLkTi=PFSxDrA8sRB7uOW=Zf+F3HPpXzHR3LN2VM-bh@mail.gmail.com>
From: Michael van der Kolff <mvanderkolff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] global mesh
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

The answer to "millions of users" simply depends on the stability of
those networks.  It is perfectly possible to have different "BATMAN
networks" and perform routing between those - that's what I stated in
the answer to your first email.

Of course, those it is perfectly possible to set up obvious cases
where BATMAN scales to "millions of users" - half of them are behind
one BATMAN router, and the other half are behind another - then there
are only two routing nodes, and very little work :P  Of course, that
might not be useful in practice...  Seriously, I suggest you do some
of your own reading into how BATMAN works, and how other mesh/P2P
routing schemes work, and why they have different scalability
profiles.  From a scalability perspective, the interesting number
isn't the number of users, but rather the number of nodes involved in
routing decisions, and how mobile they are.  In the most widely
deployed networking schemes (current mobile phone networks), we have
static network elements, with an explicit handover procedure between
different stations for end-user equipment.  End-user equipment under
those schemes doesn't get involved in routing decisions - that's why
it is not a mesh network (along with the fact that those towers
typically have a very explicit idea of where they route calls & data
sessions to).

Just go and type "mesh routing scalability" into Google Scholar and
you should be much better informed on the subject.

Cheers,

Michael

On Tue, Nov 30, 2010 at 5:12 PM, Kosta -- A Human Right
<kosta@ahumanright.org> wrote:
> Thanks for the response-
>
> Can B.A.T.M.A.N. scale to millions of users? What are the limitations
> of B.A.T.M.A.N. in this regard? Where does it excel?
>
>
>
> On Mon, Nov 29, 2010 at 1:58 PM, Marek Lindner <lindner_marek@yahoo.de> w=
rote:
>>
>> Hi,
>>
>>> We'd like to build a satellite network that serves as a backhaul to
>>> local de-centralized mesh networks. =C2=A0Local data transactions can m=
ove
>>> within the mesh, if data needs to be accessed from further away, they
>>> switch to the satellite network. An ambitious addition to this idea is
>>> to allow each device on the mesh to act as a piece of a phase array
>>> antenna.
>>>
>>> I personally understand how challenging this may be, and my expertise
>>> is (very) limited. =C2=A0Is this technically possible with technology
>>> available today? =C2=A0What would you recommend to get this done and wh=
at
>>> can we expect in terms of an end user experience?
>>
>> building decentralized local networks with a shared internet connection =
is the
>> primary use case of batman today, therefore I don't really get your ques=
tion.
>> Can you provide specific info on what you have in mind ?
>>
>> Cheers,
>> Marek
>>
>
>
>
> --
> http://iamkosta.org
>
