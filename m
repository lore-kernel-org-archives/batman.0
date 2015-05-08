Return-Path: <booray@gmail.com>
MIME-Version: 1.0
In-Reply-To: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
References: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
Date: Fri, 8 May 2015 08:49:25 -0700
Message-ID: <CAA51LVrwxpe_W7wF1eGSFXAJwQOczptBUj1v1_EAcFcGtzoQrw@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv
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

On Thu, May 7, 2015 at 10:00 AM, Joseph Zimmer <j.zimmer@telegrid.com> wrot=
e:
>         Node1=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=
=A6=E2=80=A6.Node2=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=
=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6..Node3=E2=80=A6=E2=80=A6=E2=80=
=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6Node4

Joseph, the only way I've been able to be truly successful with this
in the past is by selecting different channels for alternating links.
It required additional "nodes" but works fantastic and doesn't have a
speed reduction due to distance.

Node1......(ch a)............Node2--hardwire--Node3..........(ch
b)..........Node4--hardwire--Node5................(ch
c)...........Node6

Once the distance is far enough you can start repeating channels.
Also, you maximize your end to end throughput if your adjacent nodes
use non-adjacent channels.  I've had great success hopping buildings
in urban environments with this method.  This could also be done with
two radios in a single node, I suppose, but how you do it depends on
what your hardware is.

Good luck,

Ray
