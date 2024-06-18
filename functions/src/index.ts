import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import * as admin from 'firebase-admin';

const serviceAccount = require('../account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const auth = admin.auth();

exports.createCustomToken = onRequest(
  { timeoutSeconds: 10 },
  async (request, response) => {
    const user = request.body;
    const uid = `kakao:::${user.userId}`;

    try {
      await auth.updateUser(uid, user);
    } catch (error) {
      user['uid'] = uid;
      await auth.createUser(user);
    }
    try {
      const token = await auth.createCustomToken(uid);

      const result = {
        status: 'SUCCESS',
        code: '0000',
        message: '성공',
        data: token,
      };
      logger.log('✅', `uid:${uid} ${result}`);
      response.send(result);
    } catch (error) {
      logger.log('⛔️ Error creating custom token:', error);
      response.sendStatus(400);
    }
  },
);
