Return-Path: <schlenkerjulian@outlook.com>
From: Julian Schlenker <schlenkerjulian@outlook.com>
Subject: Extracting topology information from batman adv
Date: Fri, 10 Jan 2020 12:07:18 +0000
Message-ID: <AM7PR07MB62635634B9432C2F27D81433AA380@AM7PR07MB6263.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hello there,

for a project I have to start different processes on different nodes within=
 an ad-hoc network. Besides CPU load and other factors I would like to use =
the network information in my decision making. For example having a hop cou=
nt would be great.

I did have a look into the alfred man page, especially the "batadv-vis -f j=
sondoc" command. This one seems to do the job although I am not sure what t=
he "metric" stands for exactly.

Or is maybe using batman, not batman adv a better fit, as I do not rely on =
any additional Layer3 services? In addition the remapping of mac to ip both=
ers me a bit.

Thanks in advance!

Best regards
Julian
