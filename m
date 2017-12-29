Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
From: dan <dandenson@gmail.com>
Date: Fri, 29 Dec 2017 10:24:04 -0700
Message-ID: <CAA_JP8W2Z0sHeiQsdw+7RN6sYBsgBDLczwvHWcoNKh7OcniFTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for
 unknown clients?
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

> We know that the transtable_local inactivity/removal timer value can be e=
xtended, and we will probably do that, but we would also like to know if it=
 is possible to have b.a.t.m.a.n. ARP for the removed client in this case. =
 We prefer this approach, rather than arbitrarily changing the tt_local tim=
er to some value which may not work well in some other customer's network/a=
pplication.  I know that there is a statistically valid underlying assumpti=
on with this 10 minute inactivity timer on transtable_local, that clients w=
ill typically be "chatty".  But again, that is not the case in this applica=
tion, which is a very common one in the industry in which we operate, where=
 clients are very often fixed devices which only respond to explicit querie=
s or commands.  This is a new product and protocol for us, and this could b=
eg the question of whether or not b.a.t.man.-based meshing is the right sol=
ution in this type of application.  We believe it can be; it would just be =
helpful if we can configure it to ARP in this type of scenario.
>
> Can you please comment on how this might be possible (config or otherwise=
)?
>
> Thanks very much,
> Robert Bates


just a note, devices based on arduino with wifi or ethernet
shields/interfaces often behave this way, and MANY IoT devices do
based on other microcontrollers as a means to save battery.  So this
is going to be an increasingly common situation.
