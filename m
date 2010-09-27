Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <201009271758.03620.lindner_marek@yahoo.de>
References: <201009262057.36382.lindner_marek@yahoo.de>
	<201009261516.21774.lew.pitcher@digitalfreehold.ca>
	<97C5B1C7CD044FEDB67CC3C1E2055BDD@flightrisk>
	<201009271758.03620.lindner_marek@yahoo.de>
Date: Tue, 28 Sep 2010 10:00:21 +1300
Message-ID: <AANLkTinacNr1_eAFPiEhxx0ahPZ0_TRYYxKJZ617cFaH@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance
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

On Tue, Sep 28, 2010 at 4:58 AM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
> But thanks a lot for all your questions because it made me aware of =A0th=
e fact
> that my explanations were not clear enough. To address the matter I wrote=
 a
> document: http://www.open-mesh.org/wiki/bridge-loop-avoidance
>
> Let me know if it answers the questions raised here and also pay close
> attention to the handcrafted fancy graphics. :-)

Questions I still have:

* Does this mean that batman will now send OGMs out the bat0 interface?
* Can the LAN be added as an interface that batman will send "normal"
batman packets out, too?  So bat0 would be in a bridge br0 with e.g.
eth0, but br0 or eth0 would also be set up as an interface batman
would send/recieve batman-encapsulated packets on?

thanks

donald
