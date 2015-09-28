Return-Path: <germano.massullo@gmail.com>
References: <5609712B.6020308@gmail.com> <1942201.vOz91KHqBg@prime>
From: Germano Massullo <germano.massullo@gmail.com>
Message-ID: <5609ACD4.3050701@gmail.com>
Date: Mon, 28 Sep 2015 23:10:44 +0200
MIME-Version: 1.0
In-Reply-To: <1942201.vOz91KHqBg@prime>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Suggestions to get extended jsondoc alfred output
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Il 28/09/2015 19:35, Simon Wunderlich ha scritto:
>
>> # batadv-vis --format=3Djsondoc
>> and I got [5]
> This looks kind of incomplete - there are no neighbor information at al=
l.
I would like to debug this thing. Virtual machines firewall have been
deactivated. I don't understand why
# alfred -r 65
returns a correct output about the three nodes and instead the jsondoc
output only mentions one node...
>> Question: do you have any suggestion how I can extend the jsondoc
>> output, to get an output similar to [6]?
> I'd suggest to create a new output type (maybe call it netjson?) next t=
o the=20
> existing ones. If you look in the source code [1] You'll find a couple =
of=20
> hooks which are prepared exactly for this purpose.
>
> Thanks!
>     Simon
>
> [1] http://git.open-mesh.org/alfred.git/blob/HEAD:/vis/vis.c#l724
Thank you, I will check it.

