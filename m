Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
References: <h1pf9bti26g2966o34ml5cv4.1347057546796@email.android.com>
 <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Mon, 10 Sep 2012 12:33:56 -0300
Message-ID: <CAHD-aqJzD54DXkW+wPJV0r4zOoTedgKsSSjPS6STSAYaxfMLOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] How to force a specific network topology
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Sep 10, 2012 at 12:18 PM, Esteban Municio <emunicio@gmail.com> wrote:
> Hi Sven
>
> I don't understand very well what are you meaning. Now I have 1 bridge
> over with batman-adv:
>
> batctl if add wlan0
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
>
> Then, should I add a bridge to wlan0 and after bridge it again with the eth0?
>
> brctl addbr bridgeWlan
> brctl addif bridgeWlan wlan0
>
> batctl if add mesh-bridge
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0

Not quite. I think he meant:

brctl addbr mesh-bridge
brctl addif mesh-bridge eth0
brctl addif mesh-bridge bat0

batctl if del wlan0
brctl addbr bridgeWlan
brctl addif bridgeWlan wlan0

batctl if add bridgeWlan

and from there, ebtables.
