Return-Path: <daniel.golle@gmail.com>
References: <201004252136.25395.adebex@gmail.com>
In-Reply-To: <201004252136.25395.adebex@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Message-Id: <8B0EF841-727E-4805-BB43-D779DB6948F3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Daniel Golle <daniel.golle@gmail.com>
Date: Sun, 25 Apr 2010 22:13:37 +0200
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
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

hi adrian,


there is no authentication, encryption whatsoever built in batman. u can =
use various ways to secure the services you want to run over an insecure =
channel like WiFi:
1. the easiest way is to use a transport layer authentication and =
encryption mechanism. to do this, u have to setup wpa_supplicant and set =
a shared key (WPA-NONE method, see wpa_supplicant docs for details about =
using WPA with Ad-Hoc networks). after setting up wpa_supplicant on all =
nodes, all traffic gets encrypted using the previously setup shared key. =
this method is neither elegant nor particularly flexible, and by far not =
as secure as "traditional" WPA2-PSK, as rekeying cannot be carried out =
(therefore WPA-NONE...)
the future will hopefully bring WiFi Direct, a new WiFi standard to =
secure Ad-Hoc networks using a one-button method (a la WPS)...
2. use IP-Layer security mechanisms (IPSec)
setup an IPSec stack in transport mode on all nodes. this method allows =
using individual certificates for all clients (i.e. u gonna built an =
PKI) and is way more flexible and by magnitudes more secure than using =
just a single shared secret, even when things like proper WPA in Ad-Hoc =
networks might come up in future.
IPSec, however, is known to be horrible to setup and imho worth the =
effort only if there a a few hundret to thousand participating nodes. =
personally, i do have some basic experience with setting up IPSec on =
openwrt and i can assist u if help is needed.
3. (or 2a?) built a VPN running on top of the mesh
while this might sound like an easy task on the first look -- OpenVPN =
can be setup within minutes -- it might not be as simple... Most VPN =
solutions known to me rely central infrastructure (i.e. one or more VPN =
server reachable for the clients)
4. secure your services, for example using using Kerberos

if u'd ask me, the best is to use either Kerberos (if possible with the =
services u plan to use) or IPSec transport authentication/encryption or =
even both (they might share one central directory service feeding both, =
Kerberos and IKE, but we won't get there too soon...)

good luck!


regards

daniel
On Apr 25, 2010, at 9:36 PM, Adrian Byszuk wrote:

> Hello,
>=20
> I'm currently working on project (part of my Bachelor work) which will =
use to=20
> transfer very sensitive data over the network, and I'd like to use =
mesh=20
> networks to transfer this data. Additionally, it should also be =
possible for=20
> "normal people" to connect to this network (e.g. to surf internet).=20
> Preliminary, I've chosen BATMAN to build this network. But I've got a =
few=20
> questions regarding security of this solution:
>=20
> 1. Does BATMAN provide any method of *authenticating* nodes?
> As I've said earlier, sometimes transferred data will be highly =
sensitive (for=20
> example: information of patients health in hospital), so it's =
absolutely=20
> critical to not allow leaking this information. I can imagine =
situation when=20
> some fake nodes claim "Hey, I'm the server collecting this data"...
> I think this is also important when someone would try to destroy our =
mesh=20
> network by placing some fake nodes in it.
> 2. If point nr one isn't possible, maybe there is some other way to =
ensure=20
> security? I don't know too much about security or cryptography, but I =
can=20
> think of solutions such as openVPN or IPsec.
>=20
> Generally, the goal is to assert security of transmitting some data =
*without*=20
> losing open characteristics of mesh network.
>=20
> I will very thankful for any answers.
>=20
> Kind regards,
> Adrian

