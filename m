Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201008141646.49517.lindner_marek@yahoo.de>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTik6O4ncAn90o=01zGGvOiRiY7gzJUH-tuMr83CU@mail.gmail.com>
	<AANLkTi=Oww7jMFtVfcU56EH7OW1aw6Tms1nHWWO+HrRB@mail.gmail.com>
	<201008141646.49517.lindner_marek@yahoo.de>
Date: Mon, 16 Aug 2010 16:11:17 +0300
Message-ID: <AANLkTimpmFOrT_AnH5Fq-50uLBJswhC_T1-B3G4fC8Nc@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: multipart/mixed; boundary=00163628353c64af30048df091fa
Subject: Re: [B.A.T.M.A.N.] Nat Question
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

--00163628353c64af30048df091fa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply, a few things came up over the weekend that i
had to attend to.

Here are three tcp dump files from the internet node on bat0 and one
on eth1 (the internet port)

Really don't understand what is wrong here :-(

On Sat, Aug 14, 2010 at 5:46 PM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
>
> On Friday 13 August 2010 07:45:07 David Beaumont wrote:
> > Anything that looks obviously out of place here?
>
> I see nothing obviously wrong here.
> The best next step is using tcpdump / batctl / wireshark to find out wher=
e the
> packets get dropped. Feel free to share the result with us. =A0:-)
>
>
> Regards,
> Marek

--00163628353c64af30048df091fa
Content-Type: text/plain; charset=US-ASCII; name="tcpdump_ping.txt"
Content-Disposition: attachment; filename="tcpdump_ping.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcxcf5910

dGNwZHVtcCAtaSBiYXQwICh3aGlsc3QgcGluZyBodHRwOi8vd3d3Lmdvb2dsZS5jb20gZnJvbSBt
ZXNoIG5vZGUpDQoNCjE0OjI1OjIzLjU3ODg3OCBJUCAxOTIuMTY4LjEuMTE5LjM3NTE2ID4gMTky
LjE2OC4xLjEuNTM6IDQxMjY4KyBBQUFBPyBnb29nbGUuY29tDQouICgyOCkNCjE0OjI1OjIzLjU4
MDgxNSBJUCAxOTIuMTY4LjEuMS41MyA+IDE5Mi4xNjguMS4xMTkuMzc1MTY6IDQxMjY4IDAvMC8w
ICgyOCkNCjE0OjI1OjIzLjU4MTU3OCBJUCAxOTIuMTY4LjEuMTE5LjY0NzIwID4gMTkyLjE2OC4x
LjEuNTM6IDYzOTQ0KyBBQUFBPyBnb29nbGUuY29tDQouICgyOCkNCjE0OjI1OjIzLjU4ODY5MyBJ
UCAxOTIuMTY4LjEuMS41MyA+IDE5Mi4xNjguMS4xMTkuNjQ3MjA6IDYzOTQ0IDAvMC8wICgyOCkN
CjE0OjI1OjIzLjU5MzAwMSBJUCAxOTIuMTY4LjEuMTE5LjM3MTQ5ID4gMTkyLjE2OC4xLjEuNTM6
IDE4OTExKyBBQUFBPyBnb29nbGUuY29tDQouICgyOCkNCjE0OjI1OjIzLjU5ODY3NiBJUCAxOTIu
MTY4LjEuMS41MyA+IDE5Mi4xNjguMS4xMTkuMzcxNDk6IDE4OTExIDAvMC8wICgyOCkNCjE0OjI1
OjIzLjYwMzgyNCBJUCAxOTIuMTY4LjEuMTE5ID4gZngtaW4tZjEwNC4xZTEwMC5uZXQ6IElDTVAg
ZWNobyByZXF1ZXN0LCBpZCAxDQo2MTM0LCBzZXEgMCwgbGVuZ3RoIDY0DQoxNDoyNToyMy43MzA0
NTIgSVAgZngtaW4tZjEwNC4xZTEwMC5uZXQgPiAxOTIuMTY4LjEuMTE5OiBJQ01QIGVjaG8gcmVw
bHksIGlkIDE2MQ0KMzQsIHNlcSAwLCBsZW5ndGggNjQNCjE0OjI1OjI0LjYxMjczMCBJUCAxOTIu
MTY4LjEuMTE5ID4gZngtaW4tZjEwNC4xZTEwMC5uZXQ6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAx
DQo2MTM0LCBzZXEgMSwgbGVuZ3RoIDY0DQoxNDoyNToyNC43NDA3OTIgSVAgZngtaW4tZjEwNC4x
ZTEwMC5uZXQgPiAxOTIuMTY4LjEuMTE5OiBJQ01QIGVjaG8gcmVwbHksIGlkIDE2MQ0KMzQsIHNl
cSAxLCBsZW5ndGggNjQ=
--00163628353c64af30048df091fa
Content-Type: text/plain; charset=US-ASCII; name="tcpdump_wget.txt"
Content-Disposition: attachment; filename="tcpdump_wget.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcxcf59w1

dGNwZHVtcCAtaSBiYXQwICh3aGlsc3Qgd2dldCBodHRwOi8vd3d3Lmdvb2dsZS5jb20gZnJvbSBt
ZXNoIG5vZGUpDQoNCjQ6MjU6NTcuMjU5NDUzIElQIDE5Mi4xNjguMS4xMTkuMzc3NDYgPiAxOTIu
MTY4LjEuMS41MzogMzc4OTkrIEFBQUE/IHd3dy5nb29nbGUNCi5jb20uICgzMikNCjE0OjI1OjU3
LjMwNDA4NCBJUCAxOTIuMTY4LjEuMS41MyA+IDE5Mi4xNjguMS4xMTkuMzc3NDY6IDM3ODk5IDEv
MS8wIENOQU1FIHd3dy5sDQouZ29vZ2xlLmNvbS4gKDEwMikNCjE0OjI1OjU3LjMxNDU2MSBJUCAx
OTIuMTY4LjEuMTE5LjEyNjU2ID4gMTkyLjE2OC4xLjEuNTM6IDUxODQ4KyBBPyB3d3cuZ29vZ2xl
LmNvDQptLiAoMzIpDQoxNDoyNTo1Ny4zMjE5MjMgSVAgMTkyLjE2OC4xLjEuNTMgPiAxOTIuMTY4
LjEuMTE5LjEyNjU2OiA1MTg0OCA3LzAvMCBDTkFNRVt8ZG9tYQ0KaW5dDQoxNDoyNTo1Ny4zMjM4
NDUgSVAgMTkyLjE2OC4xLjExOS41NDM5NiA+IGZ4LWluLWYxNDcuMWUxMDAubmV0LjgwOiBTV0Ug
NTc2ODExNDI2Og0KNTc2ODExNDI2KDApIHdpbiA1ODQwIDxtc3MgMTQ2MCxub3Asbm9wLHNhY2tP
Syxub3Asd3NjYWxlIDQ+DQoxNDoyNTo1Ny40MzI3MTkgSVAgZngtaW4tZjE0Ny4xZTEwMC5uZXQu
ODAgPiAxOTIuMTY4LjEuMTE5LjU0Mzk2OiBTIDI4NjIxOTgyNTI6Mg0KODYyMTk4MjUyKDApIGFj
ayA1NzY4MTE0Mjcgd2luIDU3MjAgPG1zcyAxNDMwLG5vcCxub3Asc2Fja09LLG5vcCx3c2NhbGUg
Nj4NCjE0OjI1OjU3LjQzMzI4MSBJUCAxOTIuMTY4LjEuMTE5LjU0Mzk2ID4gZngtaW4tZjE0Ny4x
ZTEwMC5uZXQuODA6IC4gYWNrIDEgd2luIDM2DQo1DQoxNDoyNTo1Ny40MzM2NjAgSVAgMTkyLjE2
OC4xLjExOS41NDM5NiA+IGZ4LWluLWYxNDcuMWUxMDAubmV0LjgwOiBQIDE6NzgoNzcpIGFjaw0K
IDEgd2luIDM2NQ0KMTQ6MjY6MDAuNDMzNDE1IElQIDE5Mi4xNjguMS4xMTkuNTQzOTYgPiBmeC1p
bi1mMTQ3LjFlMTAwLm5ldC44MDogUCAxOjc4KDc3KSBhY2sNCiAxIHdpbiAzNjU=
--00163628353c64af30048df091fa
Content-Type: text/plain; charset=US-ASCII; name="tcpdump_wget_eth1.txt"
Content-Disposition: attachment; filename="tcpdump_wget_eth1.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcxcf59z2

dGNwZHVtcCAtaSBldGgxICh3aGlsc3Qgd2dldCBodHRwOi8vd3d3Lmdvb2dsZS5jb20gZnJvbSBt
ZXNoIG5vZGUpDQoNCjE0OjI2OjM2LjQwOTg1NyBJUCAxOTIuMTY4LjAuMTE3LjM1MTk5ID4gZngt
aW4tZjk5LjFlMTAwLm5ldC44MDogU1dFIDExODg2MTg0OTU6DQoxMTg4NjE4NDk1KDApIHdpbiA1
ODQwIDxtc3MgMTQ2MCxub3Asbm9wLHNhY2tPSyxub3Asd3NjYWxlIDQ+DQoxNDoyNjozNi40MTA0
ODIgSVAgMTkyLjE2OC4wLjExNy4xNDYwMCA+IDE5Mi4xNjguMC4xLjUzOiA0ODcyMCsgUFRSPyA5
OS4zOS4xMjUuNw0KNC5pbi1hZGRyLmFycGEuICg0MykNCjE0OjI2OjM2LjUyNDUxNyBJUCAxOTIu
MTY4LjAuMS41MyA+IDE5Mi4xNjguMC4xMTcuMTQ2MDA6IDQ4NzIwIDEvNC80ICgyMjIpDQoxNDoy
NjozNi41Mjk0NDUgSVAgZngtaW4tZjk5LjFlMTAwLm5ldC44MCA+IDE5Mi4xNjguMC4xMTcuMzUx
OTk6IFMgMzcyOTU5OTYwNDozNw0KMjk1OTk2MDQoMCkgYWNrIDExODg2MTg0OTYgd2luIDU3MjAg
PG1zcyAxNDMwLG5vcCxub3Asc2Fja09LLG5vcCx3c2NhbGUgNj4NCjE0OjI2OjM2LjUzNDQxNiBJ
UCAxOTIuMTY4LjAuMTE3LjM1MTk5ID4gZngtaW4tZjk5LjFlMTAwLm5ldC44MDogLiBhY2sgMSB3
aW4gMzY1DQoNCjE0OjI2OjM2LjUzOTc0NyBJUCAxOTIuMTY4LjAuMTE3LjM1MTk5ID4gZngtaW4t
Zjk5LjFlMTAwLm5ldC44MDogUCAxOjc4KDc3KSBhY2sNCjEgd2luIDM2NQ0KMTQ6MjY6MzkuNTM3
MDg0IElQIDE5Mi4xNjguMC4xMTcuMzUxOTkgPiBmeC1pbi1mOTkuMWUxMDAubmV0LjgwOiBQIDE6
NzgoNzcpIGFjaw0KMSB3aW4gMzY1
--00163628353c64af30048df091fa--
