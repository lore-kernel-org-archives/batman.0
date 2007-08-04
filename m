From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Sat, 4 Aug 2007 11:43:36 +0200
References: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
In-Reply-To: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708041143.37165.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello!

On Freitag 03 August 2007, Freifunk Dresden wrote:
> Hello,
> I didn't get the email for this request, so the mailling list thread
> my be brocken.
strange, anybody else experienced problems?

[...]

> > > I'm currently checking how the HNA is working, but until now I can not
[...]
> I have checked out the rv491 and it seems working. In my test environment I
> use a laptop (i386) and two wrt54gl. The wrt shows at "-d3" that the
> announced HNA is added/deleted every 1-5 seconds. The wrt that has a
> greater distance (5meter 2 walls between) adds and deletes the HNA in a
> highe frequency than the
> wrt that is about 50cm away.
> I think that HNA should not be deleted to fast because someone that is
> using this "bad" connection will get often error messages during
> surfing that the rout e is not found. It would be better if just the
> connection slow because of transmistion errors.

that should not be the case! You say even with the stable connection to your 
near-by WRT that the HNA is added/deleted every 1 - 5 SECONDS ! And even more 
often at the distant WRT (so added/deleted every SECOND ?).
Can you describe the setup and parametrization in more detail? 

> > [...]
> >
> > > Another Idea of the "-m" is to differenciate this parameter to -M
> > > <"message"> and -m <send-script>. by calling batmand -c -m send-script,
> > > batmand can setup stdin/stdou as binary file handle and fill a user-OGM
> > > with binary data that is then send.
> >
> > Even if such message-flooding ist not implemented I just thought of
> > whether there exist some standardized formats to announce such
> > services (maybe the community network markup language CNML idea) ?
> > ciao, axel
>
> I have looked through the code and have seen that the HNA is simply
> appended to
> the end of a message. if we want to send other information a TLV structure
> is needed (Tag-length-value). Batmand can ignore unknown Tags and is
> still working in the network. At moment the whole network needs an
> update at same time, because old batmand will interpret any data as HNA.
> I hope I'm not wrong :)

Do you really think of a human-readable ascii string that you want to flood 
with an arbitrary length over the mesh with content like: "Hello take a cool 
beer and see my fancy cool movie torrent-server at 105.10.bla.bub". Iam not 
against such communication but...

default OGM size: 10 bytes
OGM + HNA size: 15 bytes
OGM + example-TLV-ascii message: 95 bytes

... I am a bit scared about the amount of data which would be flooded over the 
mesh (at every originator interval) with no means for stopping the sources.

Therefore i asked if anybody knows a decent forman for describing such 
services (preferably in a short and machine readable notation). 
Perhaps another approach is to just have a kind of key-to-service list 
(similar to /etc/services with a 16bit key) just roughly indicating the type 
of offered service together with another port/ip  where further information 
(of arbitrary length) about the indicated service can be retrieved.
This would also allow to outsource part of the service-discovery to another 
daemon.


greetings,
axel
