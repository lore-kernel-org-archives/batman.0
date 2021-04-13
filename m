Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <3542676.qYy7ulQ77K@prime> <20210410003953.1234.9147@diktynna.open-mesh.org>
 <6830943.IaFvOplyQc@prime> <7463417.qeE93hC4D1@ripper>
In-Reply-To: <7463417.qeE93hC4D1@ripper>
From: Andi Depressivum <andidepressivum@gmail.com>
Date: Tue, 13 Apr 2021 16:37:42 +0200
Message-ID: <CAEX-Y1YnNo7OsEhmRiBSpJ-1sEw9ZiNSNu95HNn67217+ocP9Q@mail.gmail.com>
Subject: Re: Problems with Multiple Interfaces
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Am Di., 13. Apr. 2021 um 14:03 Uhr schrieb Sven Eckelmann <sven@narfation.org>:

> Please avoid the ath10k-ct firmware. And for ath10k, please make sure to set
> mesh_fwding=0 on the mesh(point) interface.

This is true for Wave-1 chipsets (QCA98xx) but Wave-2 Chipsets
(QCA99xx) needs the ath10-ct firmware to get 802.11s running.

Haven't got stable results with BATMAN V in a home mesh environment.
Nodes could ping each other via batctl ping but IP ping often failed.
Maybe some issues of mesh routing when many routes to the same target
had nearly the same link speeds? I'm using a dense setup of many
routers, so every router is seeing at least 2-3 neighbours. The
preferred routes (marked with a [*] in batctl o ?) switched quite
often. How is the BATMAN V metric affected by link quality & hop
count?

Regards,
Andi
