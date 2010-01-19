Return-Path: <Jaideep.Lamba@alcatel-lucent.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Jan 2010 00:29:51 -0600
Message-ID: <EACB115D0487C4459885C4B54EE8D9CF05DDAA7D@USDALSMBS02.ad3.ad.alcatel.com>
In-Reply-To: <mailman.207.1263760993.4477.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.207.1263760993.4477.b.a.t.m.a.n@lists.open-mesh.org>
From: "LAMBA Jaideep" <Jaideep.Lamba@alcatel-lucent.com>
Subject: Re: [B.A.T.M.A.N.] Security on adhoc network
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
To: b.a.t.m.a.n@lists.open-mesh.org

>> Hey Jaideep,
>>=20
>> as Sven mentioned correctly, using the WPA sequence numbers in
WPA_NONE should be ignored. Some drivers (like madwifi) have to be
teached to >> do that. Sequence numbers do not make much sense in Ad-Hoc
anyway, as there is no central management for these sequence numbers. Of
course, you >> lack some security features like detecting replay attacks
or changing session keys which you have in master/station WPA.
>>=20
>> best regards,
>> 	Simon

Hey Simon,

I understand. So does that mean all the city-wide mesh deployments we
are seeing are susceptible to reply attack etc ? Will try to follow on
Jouni's suggestion of fixing nl driver layer for 4-way handshake, GTK
mgmt to see if I can contribute to solving this problem.

Thanks for your help.
Jaideep
