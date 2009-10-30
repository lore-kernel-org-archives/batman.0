Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AEABDBB.2010704@rsm-freilassing.de>
Date: Fri, 30 Oct 2009 11:19:39 +0100
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <4AA34865.9000203@rsm-freilassing.de>	<200909072102.57854.lindner_marek@yahoo.de>	<4AA50D60.9050605@rsm-freilassing.de>
	<200909090157.53099.lindner_marek@yahoo.de>
In-Reply-To: <200909090157.53099.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Dear B.A.T.M.A.N List,

i do not like to use the -g option, to select the preffered gateway. I=20
need a complete route-information.

I'm not able to set the HNA-Route 0.0.0.0/0 because a error-message=20
appears: Invalid announced network (netmask is invalid): 0.0.0.0/0
The current workarround is, to set HNA-Routes for 0.0.0.0/1,128.0.0.0/1.

Is there a chance, that anyone make a patch to add a new option to=20
"batmand"-command, to allow /0 routes?

The -g option should be disabled, in case the /0-option is enabled.

Liebe Gr=FC=DFe aus Freilassing,

Michael Rack
RSM Freilassing
--=20
RSM Freilassing                 Tel.: +49 8654 607110
Nocksteinstr. 13                Fax.: +49 8654 670438
D-83395 Freilassing            www.rsm-freilassing.de

