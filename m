Return-Path: <steve@dymos.org.uk>
From: Stephen Thornton <steve@dymos.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 9 Oct 2013 17:28:43 +0100
Message-Id: <52ECD1A4-9BFD-4220-851F-F101F398E117@dymos.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [B.A.T.M.A.N.] regarding ALFRED and GPS
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

I am currently developing a mesh router solution for several clients. I =
have been using batman-adv in this project for almost a year (using =
OpenWRT), and it has all worked fantastically. Thanks so much guys.
I now have a requirement for GPS logging functionality, along with =
passing other data between nodes. I have already written a simple layer3 =
protocol for this purpose, but this was before ALFRED. ALFRED provides =
almost all the functionality I need apart from the fact that I really =
need to embed the alfred code within my own application. I could use it =
as is via a sys call, but it would be so much better to include the =
code. What are your feelings regarding splitting the alfred code into a =
library with can be included in other user applications, and an alfred =
client program that uses this library? I'm quite prepared to give quite =
a bit of my own time to doing this if you like the idea.

best regards
Steve Thornton=
