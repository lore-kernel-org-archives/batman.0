MIME-Version: 1.0
In-Reply-To: <20090213141846.GA17394@pandem0nium>
References: <2ced936d0902121842k7ff76dc8o7c7d303a685a78bd@mail.gmail.com>
	<20090213141846.GA17394@pandem0nium>
Date: Fri, 13 Feb 2009 21:28:24 -0300
Message-ID: <2ced936d0902131628x43ffb22eh712ec9addc03699c@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N L2 over a Bluetooth PAN
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

Hello Simon,

    Thank you for the insightful comment. I'll check this out and get
back to the list.

regards,

2009/2/13 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>:
> Hello Breno,
>
> as far as i know, for 802.11 the SNAP protocol is used to encapsulate
> the complete Ethernet Frame [1]. This means that the Ethernet header is
> completly preserved and can be decapsulated on the receiver side.
> The BNEP protocol on the other hand seems to cut off the Ethernet header
> instead of encapsalutating it when i understand the specification
> correctly [2, page 13]. However the examples [2, page 15 and page 41]
> suggest that the Ethernet Header is encapsulated completly within BNEP.
>
> For batman-adv a correct Ethernet Header, especially correct MAC Addresse=
s
> to identify the peers and support for our specific Ethernet Type is
> needed. If these fields are not (re-)generated correctly, it won't work.
>
> So the question is: is BNEP even transporting arbitrary frames with
> Ethertypes other than IP (0x0800)? Maybe there are some filters
> preventing the BATMAN frames (type 0x4305) to be transported
> [2, page 42]?
>
> I guess a good starting point would be to use some bluetooth dump tools
> or tcpdump, inject packets and see if they are received on the peer
> site. Maybe just some filter is preventing batman-adv from operation. :)
>
> best regards,
>        Simon
>
>
> [1] http://osnet.inm.nchu.edu.tw/powpoint/seminar/802.11/802.11MAC.pdf (s=
lide 28)
> [2] http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf
>
> On Thu, Feb 12, 2009 at 11:42:44PM -0300, Breno Jacinto wrote:
>> Hello,
>>
>>     I'm experimenting on heterogeneous ad hoc networks, which today
>> are still very restricted in terms of hardware availability for
>> off-the-shelf devices. Actually, the two most common technologies
>> available today are 802.11 and Bluetooth, being this last one able to
>> form simple personal area networks in the form of piconets.
>>
>>      In practical terms, the BlueZ stack of the Linux allows the
>> formation of Bluetooth PANs consisting of up to 8 nodes, but it's an
>> incredibly difficult process - actually, the piconet master needs to
>> bridge connections so that all other devices in the network, which
>> depend on this master, are able to reach it other directly - or at
>> least feel like they are doing that. In fact, everything is just an
>> emulation, since Bluetooth is a connection-oriented technology.
>>
>>      BNEP (Bluetooth Network Encapsulation Protocol) is the piece
>> responsible for emulating an Ethernet network over Bluetooth, and
>> theoretically any IP and above protocols can be used. Trying with
>> simple IP broadcasts over a Bluetooth network shows that it works, but
>> the problem comes when I try to do "straight" layer 2 broadcasts (not
>> coming from the IP layer), such as the ones that BATMAN L2 does.
>>
>>     I tried to run BATMAN and add the interfaces used on each device -
>> pan0 for the master, which is a bridge device, and bnep0 for the
>> slave, but the frame dont seem to reach any destination on the
>> network. The originators table remains empty on both sides of the
>> connection. Running Wireshark shows the frame being generated, but
>> never reaching anyone.
>>
>>     So, I still cannot figure out why this is happening. I'd like to
>> know if anyone has adventured in doing something similar and
>> succeeded.
>>
>>
>> best regards,
>>
>> --
>> --
>> :: Breno Jacinto ::
>> :: breno - at - gprt.ufpe.br ::
>> :: FingerPrint ::
>>    2F15 8A61 F566 E442 8581
>>    E3C0 EFF4 E202 74B7 7484
>> :: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil al=
gum dia.  ::
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFJlYFGrzg/fFk7axYRAmIEAJwN2joajajVtRo2bw8vv5x3EImdbwCg21WU
> iyolzJNbEPn7tMKMutqVaQc=3D
> =3DSq9K
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>



--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::
